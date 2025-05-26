class ContractsController < ApplicationController
  def index
     if current_user.nil?
       @user_contracts = []
     elsif current_user.account_type == "Brand"
       # brands see contracts they created
       @user_contracts = Contract.where({ :created_by => current_user.id }).order({ :created_at => :desc })
     else
       # athletes see only contracts they joined via Party
       @user_contracts = []
       Party.where({ :party_id => current_user.id }).each do |party|
         matching_contracts = Contract.where({ :id => party.contract_id })
         found_contract     = matching_contracts.at(0)
         @user_contracts.push(found_contract) if found_contract
       end
     end

     render({ :template => "contracts/index" })
   end


  def show
    the_id = params.fetch("path_id")

    matching_contracts = Contract.where({ :id => the_id })

    @the_contract = matching_contracts.at(0)

    @matching_tasks = Task.where({ :contract_id => @the_contract.id }).order({ :deadline => :asc })

    @completed_tasks = @matching_tasks.where({ :completion_status => "true"}).order({ :deadline => :asc })
    @pending_tasks = @matching_tasks.where({ :completion_status => "false"}).order({ :deadline => :asc })

    # load the Brand user
    @brand_user = User.where({ :id => @the_contract.created_by }).at(0)

     
    # load the first party (Athlete) on this contract
    matching_parties = Party.where({ :contract_id => @the_contract.id })
    the_party = matching_parties.at(0)
    if the_party == nil
    else
      @athlete_user = User.where({ :id => the_party.party_id }).at(0)
    end

    render({ :template => "contracts/show" })
  end

  def create
    the_contract = Contract.new
    the_contract.contract_name = params.fetch("query_contract_name")
    the_contract.description = params.fetch("query_description")
    the_contract.monetary_compensation = params.fetch("query_monetary_compensation")
    the_contract.other_compensation = params.fetch("query_other_compensation")
    the_contract.created_by = current_user.id
    
   # generate hex string
    the_contract.token = SecureRandom.hex(16) 
   
    the_contract.status = "Pending"

    if the_contract.valid?
      the_contract.save
      redirect_to("/contracts/#{the_contract.id}", { :notice => "Contract created successfully." })
    else
      redirect_to("/contracts", { :alert => the_contract.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_contract = Contract.where({ :id => the_id }).at(0)
    the_contract.contract_name = params.fetch("query_contract_name")
    the_contract.description = params.fetch("query_description")
    the_contract.monetary_compensation = params.fetch("query_monetary_compensation")
    the_contract.other_compensation = params.fetch("query_other_compensation")
    the_contract.status = params.fetch("query_status")
    # the_contract.created_by = params.fetch("query_created_by")
    # the_contract.token = params.fetch("query_token")

    if the_contract.valid?
      the_contract.save
      redirect_to("/contracts/#{the_contract.id}", { :notice => "Contract updated successfully."} )
    else
      redirect_to("/contracts/#{the_contract.id}", { :alert => the_contract.errors.full_messages.to_sentence })
    end
  end

  def update_status
    the_id = params.fetch("path_id")
    the_contract = Contract.where({ :id => the_id }).at(0)
    the_contract.status = params.fetch("query_status")
    the_contract.save

    redirect_to("/contracts/#{ the_contract.id }")
  end

  # JOINING CONTRACT THROUGH TOKEN LINK

 def join_contract
     the_token = params.fetch("the_token")
     matching_contracts = Contract.where({ :token => the_token })
     the_contract = matching_contracts.at(0)

     if current_user.nil?
       # stash the invite and send to Devise login
       session.store("invite_token", the_token)
       redirect_to("/users/sign_in",
                   { :alert => "Please log in or sign up to join the contract." })
       return
     end

     # if already linked, skip; otherwise create the Party join
     existing = Party.where({
       :contract_id => the_contract.id,
       :party_id    => current_user.id
     }).count

     if existing == 0
       new_party = Party.new
       new_party.contract_id = the_contract.id
       new_party.party_id    = current_user.id
       new_party.save
     end

     redirect_to("/contracts/#{the_contract.id}", { :notice => "You’ve joined the contract!" })
   end
 

  def destroy
    the_id = params.fetch("path_id")
    the_contract = Contract.where({ :id => the_id }).at(0)

    the_contract.destroy

    redirect_to("/contracts", { :notice => "Contract deleted successfully."} )
  end
end
