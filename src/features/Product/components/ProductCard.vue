<template>
    <NuxtLink :to="`/product/${id}`" class="product-card">
        <div class="product-card__image-wrapper">
            <NuxtImg
                class="product-card__image"
                :src="getImageUrl(images)"
                :alt="`${title} — внешний вид`"
                loading="lazy"
                format="webp"
                quality="75"
                sizes="xs:192px sm:256px md:288px lg:320px xl:368px 2xl:576px"
                placeholder
                fetchpriority="low"
            />
            <h3 class="product-card__model">
                <span class="visually-hidden">Модульный дом </span>{{ model }}
            </h3>
        </div>

        <div class="product-card__content">
            <dl v-if="dimensions || area" class="product-card__specs">
                <div v-if="dimensions" class="product-card__spec product-card__spec--dimensions">
                    <dt>Д × Ш × В</dt>
                    <dd>{{ dimensions }}</dd>
                </div>
                <div v-if="area" class="product-card__spec">
                    <dt>Площадь</dt>
                    <dd>{{ area }}</dd>
                </div>
            </dl>
            <p v-else-if="shortDescription" class="product-card__description">
                {{ shortDescription }}
            </p>
            <span class="product-card__details">Подробнее о доме</span>
        </div>
    </NuxtLink>
</template>

<script setup lang="ts">
import { getImageFromS3 } from '~/src/shared/lib/utils/getImageUrl'

const props = withDefaults(defineProps<{
    id?: string,
    title?: string,
    images?: string[],
    shortDescription?: string
}>(), {
    id: '',
    title: 'Не удалось загрузить',
    images: () => ['/images/pallete.png'],
    shortDescription: ''
})

const model = computed(() => props.title.replace(/^Модульный дом\s*/i, '') || props.title)

const dimensions = computed(() => {
    const match = props.shortDescription.match(/Д\s*(\d+)\s*[хx×]\s*Ш\s*(\d+)\s*[хx×]\s*В\s*(\d+)/i)
    return match ? `${match[1]} × ${match[2]} × ${match[3]} мм` : ''
})

const area = computed(() => {
    const match = props.shortDescription.match(/Площадь\s*:?\s*(\d+(?:[.,]\d+)?)\s*м\s*2/i)
    return match ? `${match[1]} м²` : ''
})

const getImageUrl = (images: string[]) => {
    return getImageFromS3(images[0])
}
</script>

<style lang="scss" scoped>
.product-card {
    --card-ink: #242522;
    --card-muted: #6b6d66;
    --card-rule: #ddded8;
    --card-surface: #f4f5f1;
    --card-accent: #f57c00;

    display: flex;
    flex-direction: column;
    width: 100%;
    height: 100%;
    min-width: 0;
    overflow: hidden;
    color: var(--card-ink);
    background: $colorWhite;
    border: 1px solid var(--card-rule);
    border-radius: 6px;
    text-decoration: none;
    transition: border-color 0.25s ease, box-shadow 0.25s ease;

    &:hover {
        border-color: #b7b9b0;
        box-shadow: 0 10px 24px rgba(36, 37, 34, 0.08);
    }

    &:focus-visible {
        outline: 3px solid rgba(245, 124, 0, 0.55);
        outline-offset: 4px;
    }

    &:hover .product-card__image,
    &:focus-visible .product-card__image {
        transform: scale(1.025);
    }

    &:hover .product-card__details,
    &:focus-visible .product-card__details {
        color: #9c4a00;
    }

    &__image-wrapper {
        position: relative;
        flex-shrink: 0;
        aspect-ratio: 4 / 3;
        overflow: hidden;
        background: var(--card-surface);
    }

    &__image {
        display: block;
        width: 100%;
        height: 100%;
        object-fit: cover;
        object-position: center;
        transition: transform 0.5s cubic-bezier(0.4, 0, 0.2, 1);
    }

    &__model {
        position: absolute;
        bottom: 0;
        left: 0;
        max-width: calc(100% - 1.5rem);
        margin: 0;
        padding: 0.55rem 0.85rem 0.65rem;
        overflow: hidden;
        color: var(--card-ink);
        background: $colorWhite;
        border-radius: 0 6px 0 0;
        font-size: clamp(1.75rem, 2.5vw, 2.25rem);
        font-weight: 700;
        line-height: 1;
        letter-spacing: -0.055em;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    &__content {
        display: flex;
        flex: 1;
        flex-direction: column;
        gap: 1.25rem;
        min-height: 0;
        padding: 1.25rem;
    }

    &__specs {
        display: flex;
        flex-wrap: wrap;
        gap: 0.9rem 1.5rem;
        margin: 0;
    }

    &__spec {
        flex: 1 1 4rem;
        min-width: 0;

        &--dimensions {
            flex-basis: 11rem;
        }

        dt {
            margin-bottom: 0.3rem;
            color: var(--card-muted);
            font-size: 0.75rem;
            line-height: 1.3;
        }

        dd {
            margin: 0;
            font-size: 0.9rem;
            font-variant-numeric: tabular-nums;
            line-height: 1.4;
            white-space: nowrap;
        }
    }

    &__description {
        display: -webkit-box;
        margin: 0;
        overflow: hidden;
        color: var(--card-muted);
        font-size: 0.9rem;
        line-height: 1.5;
        -webkit-box-orient: vertical;
        -webkit-line-clamp: 3;
        line-clamp: 3;
    }

    &__details {
        align-self: flex-start;
        margin-top: auto;
        color: var(--card-ink);
        font-size: 0.9rem;
        font-weight: 600;
        line-height: 1.4;
        text-decoration: underline;
        text-decoration-color: var(--card-accent);
        text-decoration-thickness: 2px;
        text-underline-offset: 5px;
        transition: color 0.2s ease;
    }

    @media (max-width: 768px) {
        &__content {
            gap: 1rem;
            padding: 1rem;
        }
    }

    @media (prefers-reduced-motion: reduce) {
        transition: none;

        &__image,
        &__details {
            transition: none;
        }

        &:hover .product-card__image,
        &:focus-visible .product-card__image {
            transform: none;
        }
    }
}

.visually-hidden {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip: rect(0, 0, 0, 0);
    white-space: nowrap;
    border: 0;
}
</style>
