module UserRepresenter
  include Roar::JSON

  property :name
  property :email
  property :created_at
  property :updated_at
end
