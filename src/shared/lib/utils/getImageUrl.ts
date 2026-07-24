export const getImageFromS3 = (image: string) => {
    if (/\.(png|jpe?g|webp|svg)$/i.test(image)) {
        return `/images/${image}`
    }
    return `/images/${image}.png`
}