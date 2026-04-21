module "rg" {
  source = "../../resource group"
  rg     = var.rg
}
module "vnet" {
  source     = "../../vnet"
  vnet       = var.vnet
  depends_on = [module.rg]
}
module "subnet" {
  source     = "../../subnet"
  subnet     = var.subnet
  depends_on = [module.vnet]

}
module "nic" {
  source     = "../../nic"
  nic        = var.nic
  depends_on = [module.subnet]

}
module "vm" {
  source     = "../../vm"
  vm         = var.vm
  depends_on = [module.nic]

}
module "bastion" {
  source     = "../../bastion"
  bastion    = var.bastion
  depends_on = [module.subnet]

}
module "agw" {
  source = "../../agw"
  agw    = var.agw
depends_on = [ module.nic ]

}