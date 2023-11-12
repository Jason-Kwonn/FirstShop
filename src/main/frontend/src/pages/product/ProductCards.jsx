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

    const [shownProductIndices, setShownProductIndices] = useState(new Set()); // 중복 확인을 위한 상태
    const maxProductsToShow = 300;

    const getRandomIndex = (excludedIndices, max) => {
        let randomIndex;
        do {
            randomIndex = Math.floor(Math.random() * max);
        } while (excludedIndices.has(randomIndex));
        return randomIndex;
    };

    const maxAdditionalProducts = 200;

    const loadMoreProducts = () => {
        // 상한치 설정
        const limitToShow = allProduct.length > 300 ? allProduct.length + maxAdditionalProducts : 300;

        if (productsToShow.length >= limitToShow) {
            return; // 상한치 초과할 경우 로딩을 중단
        }

        const newIndices = new Set(shownProductIndices);

        const additionalProducts = [];
        while (additionalProducts.length < 3 && productsToShow.length + additionalProducts.length < limitToShow) {
            if (newIndices.size === allProduct.length) { // 모든 상품을 보여줬다면 기록 초기화
                newIndices.clear();
            }
            const randomIndex = getRandomIndex(newIndices, allProduct.length);
            newIndices.add(randomIndex);
            additionalProducts.push(allProduct[randomIndex]);
        }

        setProductsToShow(prevProducts => [...prevProducts, ...additionalProducts]);
        setShownProductIndices(newIndices);
    };




    // const loadMoreProducts = () => {
    //     const nextIndex = currentIndex + 3;
    //     const additionalProducts = allProduct.slice(currentIndex, nextIndex);
    //     setProductsToShow(prevProducts => [...prevProducts, ...additionalProducts]);
    //     setCurrentIndex(nextIndex);
    // };

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
    }, [allProduct, shownProductIndices]);


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