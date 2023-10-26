import Button from 'react-bootstrap/Button';
import Card from 'react-bootstrap/Card';
import {useContext, useEffect, useState} from "react";
import {ProductContext} from "../../contexts/product/ProductContext.jsx";
import {Link} from "react-router-dom";
import "./ProductCards.css";

function ProductCards() {
    const { allProduct } = useContext(ProductContext);
    const [productsToShow, setProductsToShow] = useState([]);
    const [currentIndex, setCurrentIndex] = useState(0);

    useEffect(() => {
        // 처음에는 12개의 상품을 보여준다.
        setProductsToShow(allProduct.slice(0, 12));
        setCurrentIndex(12);
    }, [allProduct]);

    const loadMoreProducts = () => {
        const nextIndex = currentIndex + 3;
        const additionalProducts = allProduct.slice(currentIndex, nextIndex);
        setProductsToShow(prevProducts => [...prevProducts, ...additionalProducts]);
        setCurrentIndex(nextIndex);
    };

    useEffect(() => {
        const handleScroll = () => {
            if (window.innerHeight + window.scrollY >= document.body.offsetHeight - 500) {
                // 사용자가 페이지 하단에 근접하면 더 많은 상품을 로드합니다.
                loadMoreProducts();
            }
        };

        window.addEventListener('scroll', handleScroll);
        return () => {
            window.removeEventListener('scroll', handleScroll);
        };
    }, [currentIndex, allProduct]);

    return (
        <div className="container align-self-center mt-5 mb-5">
            {Array.from({ length: Math.ceil(productsToShow.length / 3) }).map((_, rowIndex) => (
                <div className="row" key={rowIndex}>
                    {productsToShow.slice(rowIndex * 3, rowIndex * 3 + 3).map((product, index) => (
                        <div className="col-md-4" key={index}>
                            <Card style={{ width: '25rem', height: '20rem', marginBottom: '1rem' }}>
                                <Card.Img className="custom-card-img" variant="top" src={`/uploadFiles/${product.fileName}`} />
                                <Card.Body>
                                    <Card.Title>{product.prodName}</Card.Title>
                                    <Card.Text>{product.prodDetail}</Card.Text>
                                    <Button as={Link} to={`/product/getProduct/${product.prodNo}`} variant="primary">구매하러 가기</Button>
                                </Card.Body>
                            </Card>
                        </div>
                    ))}
                </div>
            ))}
        </div>

    );
}

export default ProductCards;