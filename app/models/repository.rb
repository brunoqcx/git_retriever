class Repository
  include ActiveModel::Model

  attr_accessor :full_name, :description, :forks_count, :stargazers_count, :owner
end