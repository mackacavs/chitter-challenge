class Users

  attr_reader :name, :email, :username, :password

  def initialize(name:, email:, username:, password:)
    @name = name
    @email = email
    @username = username
    @password = password
  end

  def self.add(name, email, username, password)
    result = DatabaseConnection.query("INSERT INTO users (name, email, username, password) VALUES ('#{name}', '#{email}', '#{username}', '#{password}') RETURNING name, email, username, password")
    Users.new(name: result[0]['name'], email: result[0]['email'], username: result[0]['username'], password: result[0]['password'])
  end

  def self.validation(email)
    valid_email = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    email.match?(valid_email)
  end

  def self.user_exists(username)
    result = DatabaseConnection.query("SELECT * FROM users WHERE username = '#{username}'")
    new_array = []
    result.map do |user|
      new_array << user
    end
    if new_array.empty? 
      return true
    else
      return false
    end
  end

end