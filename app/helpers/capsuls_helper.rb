module CapsulsHelper

  def is_capsule_mine capsule, user
    if capsule and current_user and capsule.user_id == current_user.id
      true
    else
      false
    end
  end
end
