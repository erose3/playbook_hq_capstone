Rails.application.routes.draw do
  devise_for :users
  
  root to: "contracts#index"
  
  # Routes for the Party resource:

  # CREATE
  post("/insert_party", { :controller => "parties", :action => "create" })
          
  # READ
  get("/parties", { :controller => "parties", :action => "index" })
  
  get("/parties/:path_id", { :controller => "parties", :action => "show" })
  
  # UPDATE
  
  post("/modify_party/:path_id", { :controller => "parties", :action => "update" })
  
  # DELETE
  get("/delete_party/:path_id", { :controller => "parties", :action => "destroy" })

  #------------------------------

  # Routes for the Task resource:

  # CREATE
  post("/insert_task", { :controller => "tasks", :action => "create" })
          
  # READ
  get("/tasks", { :controller => "tasks", :action => "index" })
  
  get("/tasks/:path_id", { :controller => "tasks", :action => "show" })
  
  # UPDATE
  
  post("/modify_task/:path_id", { :controller => "tasks", :action => "update" })
  
  # DELETE
  get("/delete_task/:path_id", { :controller => "tasks", :action => "destroy" })

  #------------------------------

  # Routes for the Contract resource:

  # CREATE
  post("/insert_contract", { :controller => "contracts", :action => "create" })
          
  # READ
  get("/contracts", { :controller => "contracts", :action => "index" })
  
  get("/contracts/:path_id", { :controller => "contracts", :action => "show" })
  
  # UPDATE
  
  post("/modify_contract/:path_id", { :controller => "contracts", :action => "update" })
  
  # DELETE
  get("/delete_contract/:path_id", { :controller => "contracts", :action => "destroy" })

  #------------------------------

  
end
