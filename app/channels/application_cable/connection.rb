module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_member

    def connect
      unless env['warden'].user.nil?
        self.current_member = find_verified_member
        logger.add_tags 'ActionCable', current_member.name
      end
    end

    protected

    def find_verified_member
      verified_member = Member.find_by(id: env['warden'].user.id)
      return reject_unauthorized_connection unless verified_member
      verified_member
    end
  end
end

