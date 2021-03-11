# frozen_string_literal: true

# name: discourse-limit-stats-to-staff
# about: Limit stats to staff
# version: 0.0.21
# date: 8 March 2021
# authors: Neo
# url: https://github.com/unixneo/discourse-limit-stats-to-staff

PLUGIN_NAME = "discourse-limit-stats-to-staff"

enabled_site_setting :enable_limit_stats_to_staff

after_initialize do
   Guardian.class_eval do
     def can_see_about_stats?
       if SiteSetting.enable_limit_stats_to_staff?
        return is_staff?
       else
        return true
       end
     end
   end

  module DiscourseHubExtension
    def self.get_payload
      {}
    end
  end

  module DiscourseHub
    if SiteSetting.enable_limit_stats_to_staff?
      prepend DiscourseHubExtension
    end
  end
end          

