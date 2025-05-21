class PartiesController < ApplicationController
  def index
    matching_parties = Party.all

    @list_of_parties = matching_parties.order({ :created_at => :desc })

    render({ :template => "parties/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_parties = Party.where({ :id => the_id })

    @the_party = matching_parties.at(0)

    render({ :template => "parties/show" })
  end

  def create
    the_party = Party.new
    the_party.contract_id = params.fetch("query_contract_id")
    the_party.party_id = params.fetch("query_party_id")

    if the_party.valid?
      the_party.save
      redirect_to("/parties", { :notice => "Party created successfully." })
    else
      redirect_to("/parties", { :alert => the_party.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_party = Party.where({ :id => the_id }).at(0)

    the_party.contract_id = params.fetch("query_contract_id")
    the_party.party_id = params.fetch("query_party_id")

    if the_party.valid?
      the_party.save
      redirect_to("/parties/#{the_party.id}", { :notice => "Party updated successfully."} )
    else
      redirect_to("/parties/#{the_party.id}", { :alert => the_party.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_party = Party.where({ :id => the_id }).at(0)

    the_party.destroy

    redirect_to("/parties", { :notice => "Party deleted successfully."} )
  end
end
