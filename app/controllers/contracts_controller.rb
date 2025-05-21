class ContractsController < ApplicationController
  def index
    matching_contracts = Contract.all

    @list_of_contracts = matching_contracts.order({ :created_at => :desc })

    render({ :template => "contracts/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_contracts = Contract.where({ :id => the_id })

    @the_contract = matching_contracts.at(0)

    render({ :template => "contracts/show" })
  end

  def create
    the_contract = Contract.new
    the_contract.contract_name = params.fetch("query_contract_name")
    the_contract.monetary_compensation = params.fetch("query_monetary_compensation")
    the_contract.other_compensation = params.fetch("query_other_compensation")
    the_contract.created_by = params.fetch("query_created_by")
    the_contract.token = params.fetch("query_token")
    the_contract.tasks_count = params.fetch("query_tasks_count")

    if the_contract.valid?
      the_contract.save
      redirect_to("/contracts", { :notice => "Contract created successfully." })
    else
      redirect_to("/contracts", { :alert => the_contract.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_contract = Contract.where({ :id => the_id }).at(0)

    the_contract.contract_name = params.fetch("query_contract_name")
    the_contract.monetary_compensation = params.fetch("query_monetary_compensation")
    the_contract.other_compensation = params.fetch("query_other_compensation")
    the_contract.created_by = params.fetch("query_created_by")
    the_contract.token = params.fetch("query_token")
    the_contract.tasks_count = params.fetch("query_tasks_count")

    if the_contract.valid?
      the_contract.save
      redirect_to("/contracts/#{the_contract.id}", { :notice => "Contract updated successfully."} )
    else
      redirect_to("/contracts/#{the_contract.id}", { :alert => the_contract.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_contract = Contract.where({ :id => the_id }).at(0)

    the_contract.destroy

    redirect_to("/contracts", { :notice => "Contract deleted successfully."} )
  end
end
