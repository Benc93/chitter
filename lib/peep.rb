class Peep

  # this makes the instances of this class Datamapper resources
  include DataMapper::Resource

  # This block describes what resources our model will have
  property :id,         Serial # Serial means that it will be auto-incremented for every record
  property :published,  DateTime
  property :content,    String,   :length => 140

end