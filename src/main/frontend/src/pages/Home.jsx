import Footer from "../components/skeleton/Footer.jsx";
import {Carousel, Image} from "react-bootstrap";

function Home() {

    return (
        <>
            <Carousel className="container align-self-center col mt-5 mb-5">
                <Carousel.Item>
                    <Image src="/mainImages/9bc016bc-cd7a-49cc-a399-47930b00c59f.webp" text="First slide" />
                    <Carousel.Caption>
                        <h3>First slide label</h3>
                        <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
                    </Carousel.Caption>
                </Carousel.Item>
                <Carousel.Item>
                    {/*< text="Second slide" />*/}
                    <Carousel.Caption>
                        <h3>Second slide label</h3>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                    </Carousel.Caption>
                </Carousel.Item>
                <Carousel.Item>
                    {/*< text="Third slide" />*/}
                    <Carousel.Caption>
                        <h3>Third slide label</h3>
                        <p>
                            Praesent commodo cursus magna, vel scelerisque nisl consectetur.
                        </p>
                    </Carousel.Caption>
                </Carousel.Item>
            </Carousel>
            <Footer/>
        </>
    );
}

export default Home;
