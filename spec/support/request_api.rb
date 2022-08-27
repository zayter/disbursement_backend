# frozen_string_literal: true

module RequestAPI
  def body_json
    JSON.parse(response.body)
  end

  def authenticated_header(user = nil)
    user ||= create(:user)

    post new_user_session_path, params: { user: { email: user.email, password: user.password } }

    response.headers.slice('Authorization')
  end

  def serialized_body(serializer, resource)
    JSON.parse(
      ActiveModelSerializers::Adapter
      .create(serializer.constantize.new(resource))
      .to_json(only: [])
    )
  end
end
