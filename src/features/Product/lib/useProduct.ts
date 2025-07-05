import { computed } from 'vue'
import { PRODUCTS_DATA } from '~/src/shared/constants/PRODUCTS'
import type { IVesi } from '~/src/shared/models'

export function useProduct(id: string) {
  return computed<IVesi | undefined>(() => 
    PRODUCTS_DATA.find(p => p.id === id)
  )
}

export function useProducts() {
  return computed<IVesi[]>(() => PRODUCTS_DATA)
} 