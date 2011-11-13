class RegistrationsController < Devise::RegistrationsController
  def update
      # Override Devise to use update_attributes instead of update_with_password.
      # This is the only change we make.
      if resource.update_attributes(params[resource_name])
        set_flash_message :notice, :updated
        # Line below required if using Devise >= 1.2.0
        sign_in resource_name, resource, :bypass => true
        redirect_to after_update_path_for(resource)
      else
        clean_up_passwords(resource)
        render_with_scope :edit
      end
  end
end
