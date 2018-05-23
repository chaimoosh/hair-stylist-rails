OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '110698820370-iemb8eq7v486rb2ctu0up6qltns66en4.apps.googleusercontent.com', 'oy6lq7UOoU4t2BjaQnZsIdeM', {skip_jwt: true, client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
