import Footer from "../components/skeleton/Footer.jsx";
import {Carousel, Image} from "react-bootstrap";
import "./Home.css";
import {useNavigate} from "react-router-dom";

function Home() {
    const navigate = useNavigate();

    // Carousel 항목에 대한 정보를 갖는 배열
    const carouselItems = [
        {
            src: "/mainImages/fashion-5515135_1920.jpg",
            captionTitle: "최다 판매 상품",
            captionText: "가장 판매량이 높은 상품은 무엇일까요?",
            linkTo: "/product/getProduct/10024"
        },
        {
            src: "/mainImages/prateek-katyal-xv7-GlvBLFw-unsplash.jpg",
            captionTitle: "최다 찜 상품",
            captionText: "가장 많이 찜한 상품은 무엇일까요?",
            linkTo: "/product/getProduct/10025"
        },
        {
            src: "/mainImages/nadine-shaabana-UBvF7tGcLdg-unsplash.jpg",
            captionTitle: "최다 조회수 상품",
            captionText: "가장 조회를 많이 한 상품은 무엇일까요?",
            linkTo: "/product/getProduct/10026"
        }
    ];

    const handleClick = (linkTo) => {
        navigate(linkTo);
    };

    return (
        <>
            <Carousel className="container align-self-center col mt-5 mb-5">
                {carouselItems.map((item, index) => (
                    <Carousel.Item key={index} onClick={() => handleClick(item.linkTo)}>
                        <Image
                            src={item.src}
                            className="carousel-image"
                            role="button"
                        />
                        <Carousel.Caption>
                            <h3>{item.captionTitle}</h3>
                            <p>{item.captionText}</p>
                        </Carousel.Caption>
                    </Carousel.Item>
                ))}
                {/*<Carousel.Item>*/}
                {/*    <Image src="/mainImages/prateek-katyal-xv7-GlvBLFw-unsplash.jpg"*/}
                {/*           className="carousel-image"*/}
                {/*    />*/}
                {/*    <Carousel.Caption as={Link} to="/product/getProduct/10025">*/}
                {/*        <h3>최다 찜 상품</h3>*/}
                {/*        <p>가장 많이 찜한 상품은 무엇일까요?</p>*/}
                {/*    </Carousel.Caption>*/}
                {/*</Carousel.Item>*/}
                {/*<Carousel.Item>*/}
                {/*    <Image src="/mainImages/nadine-shaabana-UBvF7tGcLdg-unsplash.jpg"*/}
                {/*           className="carousel-image"*/}
                {/*    />*/}
                {/*    <Carousel.Caption as={Link} to="/product/getProduct/10026">*/}
                {/*        <h3>최다 조회수 상품</h3>*/}
                {/*        <p>가장 조회를 많이 한 상품은 무엇일까요?</p>*/}
                {/*    </Carousel.Caption>*/}
                {/*</Carousel.Item>*/}
            </Carousel>
            <Footer/>
        </>
    );
}

export default Home;
