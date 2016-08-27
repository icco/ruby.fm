# RailsAdmin.config do |config|

#   ### Popular gems integration

#   ## == Devise ==
#   config.authenticate_with do
#     redirect_to main_app.root_path unless current_user.try(:admin?)
#   end
#   config.current_user_method(&:current_user)

#   ## == Cancan ==
#   # config.authorize_with :cancan

#   ## == PaperTrail ==
#   # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

#   ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

#   config.actions do
#     dashboard                     # mandatory
#     index                         # mandatory
#     new
#     export
#     bulk_delete
#     show
#     edit
#     delete
#     show_in_app

#     ## With an audit adapter, you can add:
#     # history_index
#     # history_show
#   end

#   config.model Episode do
#     list do
#       sort_by :created_at
#       field :title
#       field :channel
#       field :created_at do
#         sort_reverse true
#       end
#     end
#   end
# end
