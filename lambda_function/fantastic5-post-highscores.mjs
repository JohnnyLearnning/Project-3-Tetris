import AWS from 'aws-sdk';

const db = new AWS.DynamoDB({ region: 'us-east-1' });
const TABLE_NAME = 'fantastic_5'; // TYPE YOUR TABLE NAME HERE
const parse = JSON.parse;

export const handler = async (event) => {
    const body = parse(event.body);

    if (!body.playername) {
        return {
            statusCode: 400,
            body: JSON.stringify('Missing playername')
        };
    }
    if (!body.score) {
        return {
            statusCode: 400,
            body: JSON.stringify('Missing score')
        };
    }

    const params = {
        TableName: TABLE_NAME,
        Item: {
            'playername': { S: body.playername },
            'score': { N: String(body.score) }
        }
    };

    await db.putItem(params).promise();

    return {
        statusCode: 200,
        headers: {
            'Access-Control-Allow-Credentials': true,
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': '*',
            'Access-Control-Allow-Headers': '*',
            'Content-Type': 'application/json'
        }
    };
};

    // Check if playername and score are present

