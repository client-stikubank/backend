module CustomTokenResponse
  def body
    current_user = User.find(@token.resource_owner_id)

    additional_data = {
      'email': current_user.email,
      'role': current_user.role,
    }

    super.merge(additional_data)
  end
end