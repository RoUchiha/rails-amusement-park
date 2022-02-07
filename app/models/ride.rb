class Ride < ActiveRecord::Base

    belongs_to :attraction
    belongs_to :user 

    def take_ride 
        if self.user.tickets < self.attraction.tickets && self.user.height > self.attraction.min_height
            return "Sorry. You do not have enough tickets to ride the #{self.attraction.name}."
        elsif self.user.height < self.attraction.min_height && self.user.tickets > self.attraction.tickets
            return "Sorry. You are not tall enough to ride the #{self.attraction.name}."
        elsif self.user.height < self.attraction.min_height && self.user.tickets < self.attraction.tickets
            return "Sorry. You do not have enough tickets to ride the #{self.attraction.name}." + " You are not tall enough to ride the #{self.attraction.name}."
        else
            new_happiness = self.user.happiness + self.attraction.happiness_rating
            new_tickets = self.user.tickets - self.attraction.tickets 
            new_nausea = self.user.nausea + self.attraction.nausea_rating
            self.user.update(
                :happiness => new_happiness,
                :tickets => new_tickets,
                :nausea => new_nausea
            )
            "Thanks for riding the #{self.attraction.name}!"
        end
    end

end
