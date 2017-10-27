class CiBuild
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  field :branch, :type => String
  field :committer_name, :type => String
  field :stop_time, :type => String
  field :outcome, :type => String
end
