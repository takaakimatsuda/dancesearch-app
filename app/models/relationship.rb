class Relationship < ApplicationRecord
  belongs_to :following, class_name: "User"
  belongs_to :follower, class_name: "User"
  
  # ransacker :followers_count do
  #   query = '(SELECT COUNT(relationships.follower_id) FROM relationships GROUP BY relationships.follower_id ORDER BY count(relationships.follower_id) DESC)'
  #   Arel.sql(query)
  # end
  
end
