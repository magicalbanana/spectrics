class User
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  field :name, :type => String
  field :email, :type => String
  field :team, :type => String
end
