def sign_in(user)
  cookies.permanent.signed[:remember_token] = { value: user.remember_token }
end
