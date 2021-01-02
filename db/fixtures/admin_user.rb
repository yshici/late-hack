User.seed_once(
  id: 1,
  name: '管理人',
  email: Rails.application.credentials.admin_user[:email],
  crypted_password: User.encrypt(Rails.application.credentials.admin_user[:password]),
  role: 'admin'
)
