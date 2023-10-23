import Button from 'react-bootstrap/Button';
import Card from 'react-bootstrap/Card';

function Cards() {
    return (
        <Card style={{ width: '20rem', height: '15rem', marginBottom: '1rem' }}>
            <Card.Img variant="top" src="holder.js/100px180" />
            <Card.Body>
                <Card.Title>Card Title</Card.Title>
                <Card.Text>
                    Some quick example text to build on the card title and make up the
                    bulk of content.
                </Card.Text>
                <Button variant="primary">Go somewhere</Button>
            </Card.Body>
        </Card>
    );
}

export default Cards;