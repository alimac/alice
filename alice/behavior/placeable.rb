module Alice

  module Behavior

    module Placeable

      def self.included(klass)
        klass.extend ClassMethods
      end
    
      def drop
        self.place = Alice::Place.current
        self.user = nil
        self.picked_up_at = nil
        self.save
      end

      def hide(nick)
        self.place = nil
        self.user = nil
        self.is_hidden = true
        self.picked_up_at = nil
        self.save
      end

      module ClassMethods
      
        def self.claimed
          excludes(user_id: nil)
        end

        def self.hidden
          excludes(place_id: nil)
        end

        def self.reset_hidden!
          hidden.map{|obj| obj.update_attribute(place: nil) }
        end

        def self.unclaimed
          where(user_id: nil)
        end

        def self.unplaced
          where(place_id: nil)
        end

      end

    end

  end

end