# Users
User.create!(name:'Admin', email:'admin@sistemadefrete.com.br', password:'password', user_access: :admin_user)
User.create!(name:'Edna', email:'edna@sistemadefrete.com.br', password:'password', user_access: :regular_user)
#
#
# VehicleTypes
indefinido = VehicleType.create!(vehicle_type: :undefined)
utilitario = VehicleType.create!(vehicle_type: :utility_vehicle)
carro = VehicleType.create!(vehicle_type: :car)
bicicleta = VehicleType.create!(vehicle_type: :bicycle)
moto = VehicleType.create!(vehicle_type: :motorcycle)
#
#
# DeliveryModalities
expressa = DeliveryModality.create!(mod_name: 'Expressa', mod_price: '15')
ecologica = DeliveryModality.create!(mod_name: 'Ecológica', mod_price: '7')
padrao = DeliveryModality.create!(mod_name: 'Padrão', mod_price: '5')
#
#
# DistanceCategories
d1_expressa = DistanceCategory.create!(min_distance: 100, max_distance: 9900, distance_price: 0.5, delivery_modality: expressa, delivery_time: 12)
d2_expressa = DistanceCategory.create!(min_distance: 10000, max_distance: 19900, distance_price: 0.6, delivery_modality: expressa, delivery_time: 12)
d3_expressa = DistanceCategory.create!(min_distance: 20000, max_distance: 29900, distance_price: 0.7, delivery_modality: expressa, delivery_time: 12)
d4_expressa = DistanceCategory.create!(min_distance: 30000, max_distance: 40000, distance_price: 0.8, delivery_modality: expressa, delivery_time: 12)
#
d1_padrao = DistanceCategory.create!(min_distance: 100, max_distance: 9900, distance_price: 0.5, delivery_modality: padrao, delivery_time: 36)
d2_padrao = DistanceCategory.create!(min_distance: 10000, max_distance: 19900, distance_price: 0.6, delivery_modality: padrao, delivery_time: 36)
d3_padrao = DistanceCategory.create!(min_distance: 20000, max_distance: 29900, distance_price: 0.7, delivery_modality: padrao, delivery_time: 36)
d4_padrao = DistanceCategory.create!(min_distance: 30000, max_distance: 40000, distance_price: 0.8, delivery_modality: padrao, delivery_time: 36)
#
d1_ecologica = DistanceCategory.create!(min_distance: 100, max_distance: 990, distance_price: 0.5, delivery_modality: ecologica, delivery_time: 13)
d2_ecologica = DistanceCategory.create!(min_distance: 1000, max_distance: 1990, distance_price: 0.6, delivery_modality: ecologica, delivery_time: 13)
d3_ecologica = DistanceCategory.create!(min_distance: 2000, max_distance: 4900, distance_price: 0.7, delivery_modality: ecologica, delivery_time: 14)
d4_ecologica = DistanceCategory.create!(min_distance: 5000, max_distance: 7000, distance_price: 0.8, delivery_modality: ecologica, delivery_time: 14)
#
#
# LoadCategories
l1_expressa = LoadCategory.create!(min_weight: 0, max_weight: 5, weight_price: 0.8, delivery_modality: expressa)
l2_expressa = LoadCategory.create!(min_weight: 6, max_weight: 9, weight_price: 0.9, delivery_modality: expressa)
l3_expressa = LoadCategory.create!(min_weight: 10, max_weight: 29, weight_price: 0.95, delivery_modality: expressa)
l4_expressa = LoadCategory.create!(min_weight: 30, max_weight: 50, weight_price: 1.1, delivery_modality: expressa)
#
l1_padrao = LoadCategory.create!(min_weight: 0, max_weight: 5, weight_price: 0.2, delivery_modality: padrao)
l2_padrao = LoadCategory.create!(min_weight: 6, max_weight: 20, weight_price: 0.3, delivery_modality: padrao)
l3_padrao = LoadCategory.create!(min_weight: 21, max_weight: 30, weight_price: 0.4, delivery_modality: padrao)
l3_padrao = LoadCategory.create!(min_weight: 31, max_weight: 50, weight_price: 0.5, delivery_modality: padrao)
#
l1_ecologica = LoadCategory.create!(min_weight: 0, max_weight: 2, weight_price: 1, delivery_modality: ecologica)
l2_ecologica = LoadCategory.create!(min_weight: 3, max_weight: 4, weight_price: 1.5, delivery_modality: ecologica)
l3_ecologica = LoadCategory.create!(min_weight: 5, max_weight: 7, weight_price: 2, delivery_modality: ecologica)
l4_ecologica = LoadCategory.create!(min_weight: 8, max_weight: 9, weight_price: 3, delivery_modality: ecologica)
#
#
# Vehicles
fusca1 = Vehicle.create!(licence_plate: 'ABC1100', status: :unavailable, year: 2.days.ago, vehicle_type: carro, model: 'Fusca', load_capacity: 100)
fusca2 = Vehicle.create!(licence_plate: 'ABC1102', status: :available, year: 2.days.ago, vehicle_type: carro, model: 'Fusca', load_capacity: 100)
fusca3 = Vehicle.create!(licence_plate: 'ABC1103', status: :available, year: 2.days.ago, vehicle_type: carro, model: 'Fusca', load_capacity: 100)
#
cg1 = Vehicle.create!(licence_plate: 'CDE1000', status: :available, year: 1.year.ago, vehicle_type: moto, model: 'CG-125', load_capacity: 36)
cg2 = Vehicle.create!(licence_plate: 'CDE1002', status: :available, year: 1.year.ago, vehicle_type: moto, model: 'CG-125', load_capacity: 36)
cg3 = Vehicle.create!(licence_plate: 'CDE1003', status: :available, year: 1.year.ago, vehicle_type: moto, model: 'CG-125', load_capacity: 36)
#
monark1 = Vehicle.create!(licence_plate: 'BIC0001', status: :available, year: 1.year.ago, vehicle_type: bicicleta, model: 'Monark', load_capacity: 15)
monark2 = Vehicle.create!(licence_plate: 'BIC0002', status: :available, year: 1.year.ago, vehicle_type: bicicleta, model: 'Monark', load_capacity: 15)
monark3 = Vehicle.create!(licence_plate: 'BIC0003', status: :available, year: 1.year.ago, vehicle_type: bicicleta, model: 'Monark', load_capacity: 15)
#
van1 = Vehicle.create!(licence_plate: 'BES0001', status: :available, year: 1.year.ago, vehicle_type: utilitario, model: 'Best-A', load_capacity: 1500)
van2 = Vehicle.create!(licence_plate: 'BES0002', status: :available, year: 1.year.ago, vehicle_type: utilitario, model: 'Best-A', load_capacity: 1500)
#
#
# ServiceOrders
encomenda_cris = ServiceOrder.create!(departure_address: 'Av. Araucária, 100 Curitiba - PR', delivery_address: 'Av. Getúlio Vargas, 300 Curitiba - PR', comments: 'Falar com Cris', shipping_distance: 10000, goods_weight: 2 )
#
encomenda_rute = ServiceOrder.create!(departure_address: 'Rua Pérola, 100 Curitiba - PR', delivery_address: 'Rua Francisco Derosso, 300 Curitiba - PR', comments: 'Falar com Rute', shipping_distance: 800, goods_weight: 12 )
#
encomenda_diomira = ServiceOrder.create!(departure_address: 'Rua Cascavel, 100 Curitiba - PR', delivery_address: 'Rua Marechal Floriano Peixoto, 12300 Curitiba - PR', comments: 'Falar com Diomira', shipping_distance: 2800, goods_weight: 3 )
#
#
# VehicleTypeSelections
ex_utilitario = VehicleTypeSelection.create!(vehicle_type: utilitario, delivery_modality: expressa)
ex_carro = VehicleTypeSelection.create!(vehicle_type: carro, delivery_modality: expressa)
ex_moto = VehicleTypeSelection.create!(vehicle_type: moto, delivery_modality: expressa)
ex_bicicleta = VehicleTypeSelection.create!(vehicle_type: bicicleta, delivery_modality: expressa)
#
eco_bicicleta = VehicleTypeSelection.create!(vehicle_type: bicicleta, delivery_modality: ecologica)
#
p_utilitario = VehicleTypeSelection.create!(vehicle_type: utilitario, delivery_modality: padrao)
p_carro = VehicleTypeSelection.create!(vehicle_type: carro, delivery_modality: padrao)
p_moto = VehicleTypeSelection.create!(vehicle_type: moto, delivery_modality: padrao)
#
#
#Quotation
orcamento_encomenda_cris = Quotation.create!(delivery_modality: expressa, load_category: l1_expressa, distance_category: d2_expressa, service_order: encomenda_cris)
#
#
#ShippingOrder
entrega_cris = ShippingOrder.create!(service_order: encomenda_cris, quotation: orcamento_encomenda_cris)
entrega_cris.update(late_comments: nil)