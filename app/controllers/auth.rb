####### USERS AUTH #######

def check_show_user
  redirect_to signin_path unless signed_in?
  # flash here
end
# => BEFORE :index, :show

def check_edit_user
  redirect_to signin_path unless signed_in? && (@user.id == current_user.id ||
   current_user.admin)
  # flash here
end
# => BEFORE :edit, :update, :destroy

def check_user_session
  redirect_to current_user if signed_in? && !current_user.admin
  # flash here
end
# => BEFORE :new

####### SESSIONS AUTH #######

def check_user_session
  redirect_to current_user if signed_in?
  # flash here
end
# => BEFORE :new, :create

def check_destroy_session
  redirect_to signin_path unless signed_in?
  # flash here
end
# => BEFORE :destroy

####### CATEGORIES AUTH #######

def check_user_admin
  redirect_to signin_path unless signed_in? && current_user.admin
  # flash here
end
# => BEFORE :all

####### ITEMS AUTH #######

def auth_new_item
  redirect_to signin_path unless signed_in? 
  # flash here
end
# => BEFORE :new, :create

def auth_edit_update_destroy_item
  redirect_to signin_path unless signed_in? && 
                                (@item.user_id == current_user.id || current_user.admin)
  # flash here
end
# => BEFORE :edit, :update, :destroy
