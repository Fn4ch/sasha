const VITE_S3_URL = import.meta.env.VITE_S3_URL

export const getImageFromS3 = (image: string) => {
    if (!image) return `${VITE_S3_URL}/images/placeholder.png`
    if(VITE_S3_URL) {
        return `${VITE_S3_URL}/images/${image}.png`
    }
    return `/images/${image}.png`
}