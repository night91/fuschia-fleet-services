module Api
  module SkillsApi
    def character_skills(character_id)
      get("#{@endpoint}/characters/#{character_id}/skills/")
    end
  end
end