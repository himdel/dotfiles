ENV['RAILS_ENV'] = 'development'
MIQ_DIR = File.directory?('spec/manageiq') ? './spec/manageiq' : '.'

require MIQ_DIR + '/config/environment'

models = %w(AvailabilityZone CloudNetwork CloudObjectStoreContainer CloudSubnet CloudTenant
            CloudVolume ContainerGroup ContainerImage ContainerNode ContainerProject
            ContainerTemplate ContainerVolume EmsCluster ExtManagementSystem
            GenericObject GenericObjectDefinition Host LoadBalancer
            MiqGroup MiqTemplate NetworkRouter OrchestrationStack PersistentVolume SecurityGroup Service
            ServiceTemplate Storage Switch Tenant User Vm VmOrTemplate).freeze

if ARGV.include?("delete_previous")
  ActiveRecord::Base.transaction do
    all_tables = [CustomButton, CustomButtonSet]

    all_tables.each do |table|
      table.destroy_all

      puts("Deleted: " + table.name)
    end
  end
end

models.each do |model|
  button = CustomButton.create!(:name => "Button: " + model,
                                :description => 'Button: ' + model,
                                :applies_to_class => model,
                                options: {:display => true,
                                          :open_url => false,
                                          :display_for => "single",
                                          :submit_how => "one",
                                          :button_icon => "fa fa-star",
                                          :button_color => "#2d7623"},
                                :userid => "admin",
                                visibility: {:roles=>["_ALL_"]},
                                applies_to_id: nil,
                                enablement_expression: nil,
                                disabled_text: nil
  )
  group = CustomButtonSet.create!(:name => 'Group: ' + model,
                          :description => 'Group: ' + model,
                          :set_type => "CustomButtonSet",
                          :set_data => {:button_order => nil,
                                        :display => true,
                                        :applies_to_class => model,
                                        :group_index => 1,
                                        :button_icon => "fa fa-star",
                                        :button_color => "#2d7623"})
  group[:set_data][:button_order] = [button.id]
  button.uri_attributes = {"request" => "create"}
  button.parent = group
  button.save!
  group.save!
end
