class MainPanelsController < ActionController::Base
  include RethinkDB::Shortcuts
  layout "application"

  def index
    # r.table('users').changes.run(conn).each{|change| p(change)}
  end

end