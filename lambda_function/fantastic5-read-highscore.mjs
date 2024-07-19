import AWS from 'aws-sdk';
const db = new AWS.DynamoDB.DocumentClient({ region: 'us-east-1' });

const TABLE_NAME = 'fantastic_5'; // Insert your table name here

const highScores = async () => {
    const params = {
        TableName: TABLE_NAME
    }
    const scores = await db.scan(params).promise();
    return scores;
}

export const handler = async () => {
    const scores = await highScores();
    const response = {
        statusCode: 200,
        headers: {
            "Access-Control-Allow-Headers" : "*",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "*"
        },
        body: JSON.stringify(scores),
    };
    return response;
};