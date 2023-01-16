base_name = "affreen_jha"
location  = "eastus"
#network_security_grp_name = "my_first_rule"
nsg_rules = [{
  name                       = "AllowWebIn"
  priority                   = 100
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "80"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
  },
  {
    name                       = "AllowSSLIn"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]
address_space    = ["10.0.0.0/16"]
#subnet_addr_prfx = ["10.0.1.0/24"]