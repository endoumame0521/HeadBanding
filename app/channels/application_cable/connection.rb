module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_member

    def connect
      self.current_member = find_verified_member
      logger.add_tags 'ActionCable',
                      current_member.id,
                      current_member.name
    end

    protected
    def find_verified_member
      Member.find(session['warden.user.member.key'][0][0])
    rescue
      reject_unauthorized_connection
    end

    def session
      @session ||= cookies.encrypted[Rails.application.config.session_options[:key]]
    end
  end
end

