export const handler = async (event, context) => {
    let user = ''
    try {
        user = event.body
    } catch (err) {
        user = "user not exists"
    }
    return {
        statusCode: 200,
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            message: "success",
            user: user
        }),
    }
