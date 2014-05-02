Role.where(name: 'Super Admin').first_or_create
Role.where(name: 'Admin').first_or_create

Category.where(name: 'Medicina').first_or_create
Category.where(name: 'Abarrote').first_or_create
Category.where(name: 'Perfumería').first_or_create

Unit.where(name: 'Kilogramo').first_or_create
Unit.where(name: 'Caja').first_or_create
Unit.where(name: 'Pieza').first_or_create
