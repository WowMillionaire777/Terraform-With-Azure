locals {
  resource_group_name="app-grp"
  location="North Europe"  
  
  networksecuritygroup_rules=[
    {
      priority=200
      destination_port_range="3389"
    },
    {
      priority=300
      destination_port_range="80"
    }
  ]
}