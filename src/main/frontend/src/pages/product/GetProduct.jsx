import Button from 'react-bootstrap/Button';
import Form from 'react-bootstrap/Form';
import {Link, useParams} from "react-router-dom";
import {useEffect, useState} from "react";
import {Col, Image, Row} from "react-bootstrap";
import Container from "react-bootstrap/Container";

// eslint-disable-next-line react/prop-types
function GetProduct() {
    const {prodNo} = useParams();
    // const [validated, setValidated] = useState(false);
    // const [isPurchaseQtyValid, setIsPurchaseQtyValid] = useState(false);
    const [product, setProduct] = useState({});

    useEffect(() => {
        const fetchProduct = async () => {
            try {
                const response = await fetch(`/product/getProduct/${prodNo}`);
                const oneProductData = await response.json();

                if (response.ok) {
                    setProduct(oneProductData);
                    console.log("fetch getProduct ok!!")
                }
            } catch (error) {
                console.error(error);
            }
        };
        fetchProduct();
    }, [prodNo]);


    const handleSubmit = async (event) => {

        try {
            event.preventDefault();
            const response = await fetch('/purchase/addPurchase', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(product),
            });

            if (response.ok) {
                alert("구매 완료!");
            }
            // setValidated(true);
            window.location.href = "/product/getProductList";

        } catch (error) {
            console.error(error);
        }

    };

    const handleChange = (e) => {
        // const { name, value } = e.target;
        setProduct(prev =>({
            ...prev,
            [e.target.name]: e.target.value,
        }));

        // if (e.target.name === 'purchaseQty') {
        //     const isNumericOrNegative = /^-?[0-9]+(\.[0-9]+)?$/.test(e.target.value);
        //     if (!isNumericOrNegative) {
        //         console.log("수량 형식이 잘못되었습니다. 1 이상의 정수만 입력해 주세요.");
        //     } else {
        //         setIsPurchaseQtyValid(isNumericOrNegative);
        //     }
        // }

    };

    return (
        <>
            <Container>
            <Form onSubmit={handleSubmit}
                  className="container col-md-5 align-self-center mt-5 col-form-label-lg col-form-text-lg form">
                <Form.Text className="text-center">
                    <h1>상품 구매</h1>
                </Form.Text>
                <Form.Group className="mb-3" controlId="prodNo">
                    <Row>
                        <Col sm="6">
                            <Form.Label>상품번호</Form.Label>
                        </Col>
                        <Col sm="6" className="text-end">
                            <Form.Control type="hidden" name="prodNo" value={product.prodNo} />
                            <Form.Text>{product.prodNo}</Form.Text>
                        </Col>
                    </Row>
                </Form.Group>

                <Form.Group className="mb-3" controlId="fileName">
                    <Row>
                        <Col sm="6">
                            <Form.Label>상품 이미지</Form.Label>
                        </Col>
                        <Col sm="6" className="d-flex justify-content-center">
                            <Form.Control type="hidden" name="fileName" value={product.fileName} />
                            <Image src={`/uploadFiles/${product.fileName}`} thumbnail/>
                        </Col>
                    </Row>
                </Form.Group>

                <Form.Group className="mb-3" controlId="prodName">
                    <Row>
                        <Col sm="6">
                            <Form.Label>상품명</Form.Label>
                        </Col>
                        <Col sm="6" className="text-end">
                            <Form.Control type="hidden" name="prodName" value={product.prodName} />
                            <Form.Text>{product.prodName}</Form.Text>
                        </Col>
                    </Row>
                </Form.Group>
                <Form.Group className="mb-3" controlId="prodDetail">
                    <Row>
                        <Col sm="6">
                            <Form.Label>상품설명</Form.Label>
                        </Col>
                        <Col sm="6" className="text-end">
                            <Form.Control type="hidden" name="prodDetail" value={product.prodDetail} />
                            <Form.Text>{product.prodDetail}</Form.Text>
                        </Col>
                    </Row>
                </Form.Group>
                <Form.Group className="mb-3" controlId="manuDate">
                    <Row>
                        <Col sm="6">
                            <Form.Label>제조일자</Form.Label>
                        </Col>
                        <Col sm="6" className="text-end">
                            <Form.Control type="hidden" name="manuDate" value={product.manuDate} />
                            <Form.Text>{product.manuDate}</Form.Text>
                        </Col>
                    </Row>
                </Form.Group>
                <Form.Group  className="mb-3" controlId="price">
                    <Row>
                        <Col sm="6">
                            <Form.Label>가격</Form.Label>
                        </Col>
                        <Col sm="6" className="text-end">
                            <Form.Control type="hidden" name="price" value={product.price} />
                            <Form.Text>{product.price?.toLocaleString()}</Form.Text>
                        </Col>
                    </Row>
                </Form.Group>
                <Form.Group  className="mb-3" controlId="purchaseQty">
                    <Row>
                        <Col sm="6">
                            <Form.Label>구매수량</Form.Label>
                        </Col>
                        <Col sm="6" className="text-end">
                            <Form.Control
                                name="purchaseQty"
                                type="text"
                                defaultValue="1"
                                onChange={handleChange}
                                // isInvalid={!isPurchaseQtyValid}
                            />
                        </Col>
                    </Row>
                    {/*<Form.Control.Feedback>*/}
                    {/*    입력 완료*/}
                    {/*</Form.Control.Feedback>*/}
                    {/*<Form.Control.Feedback type="invalid" >*/}
                    {/*    1 이상의 값을 입력해 주세요.*/}
                    {/*</Form.Control.Feedback>*/}
                </Form.Group>
                <Form.Group className="text-end" >
                    <Button id="cancel" variant="secondary" as={Link} to="/product/getProductList">취소</Button>
                    <Button id="submit" className="m-2" type="submit" variant="primary">구매</Button>
                </Form.Group>
            </Form>
            </Container>
        </>
    );
}

export default GetProduct;