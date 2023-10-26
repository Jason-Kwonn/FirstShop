import Container from 'react-bootstrap/Container';
import Nav from 'react-bootstrap/Nav';
import Navbar from 'react-bootstrap/Navbar';
import NavDropdown from 'react-bootstrap/NavDropdown';
import {Button, Form} from "react-bootstrap";
import {useContext, useState} from "react";
import LoginModal from "../../pages/user/LoginModal.jsx";
import AddUserModal from "../../pages/user/AddUserModal.jsx";
import {Link} from "react-router-dom";
import {AuthUserContext} from "../../contexts/user/AuthUserContext.jsx";
import {UserContext} from "../../contexts/user/UserContext.jsx";

function NavBar() {

    const { user } = useContext(UserContext);
    const {isLoggedIn, setIsLoggedIn} = useContext(AuthUserContext);
    const [showLoginModal, setShowLoginModal] = useState(false);
    const [showAddUserModal, setShowAddUserModal] = useState(false);

    const handleLoginClose = () => setShowLoginModal(false);
    const handleAddUserClose = () => setShowAddUserModal(false);

    const loginSuccess = () => {
        setIsLoggedIn(true);
        console.log("Logged In!");
        console.log(user);
    }

    const logoutUser = async () => {
        setIsLoggedIn(false);

        const response = await fetch("/user/logout");
        if (response.ok) {
            console.log("Logout 완료!!");
            window.location.href = "/";
        }
    };


    return (
        <Navbar expand="lg" className="bg-body-tertiary navbar-bottom-margin">
            <Container>
                <Navbar.Brand href="/">Rafflex</Navbar.Brand>
                <Navbar.Toggle aria-controls="basic-navbar-nav" />
                <Navbar.Collapse id="basic-navbar-nav">
                    <Nav className="me-auto">
                        <NavDropdown title="쇼핑하기" id="basic-nav-dropdown">
                            <NavDropdown.Item as={Link} to="/product/getProductList">상품 리스트</NavDropdown.Item>
                            <NavDropdown.Divider />
                            <NavDropdown.Item as={Link} to="/purchase/getPurchaseList">구매 정보</NavDropdown.Item>
                        </NavDropdown>
                        <Nav.Link as={Link} to="/raffle">Raffle</Nav.Link>
                    </Nav>

                    <Nav>
                        {isLoggedIn ? (
                            <>
                                <Nav.Link as={Link} to="/user/getUser" >내정보</Nav.Link>
                                <Nav.Link onClick={logoutUser}>로그아웃</Nav.Link>
                                <Form className="d-flex" style={{marginRight: '20px'}}>
                                    <Form.Control
                                        type="search"
                                        placeholder="Search"
                                        className="me-2"
                                        aria-label="Search"
                                    />
                                    <Button variant="outline-success">Search</Button>
                                </Form>
                            </>
                        ) : (
                            <>
                                <LoginModal show={showLoginModal} handleClose={handleLoginClose} onLoginSuccess={loginSuccess}/>
                                <AddUserModal show={showAddUserModal} handleClose={handleAddUserClose} />
                                <Form className="d-flex" style={{marginRight: '20px'}}>
                                    <Form.Control
                                        type="search"
                                        placeholder="상품명 or 래플"
                                        className="me-2"
                                        aria-label="search"
                                    />
                                    <Button variant="outline-success">Search</Button>
                                </Form>
                            </>
                        )}
                    </Nav>
                </Navbar.Collapse>
            </Container>
        </Navbar>
    );
}

export default NavBar;