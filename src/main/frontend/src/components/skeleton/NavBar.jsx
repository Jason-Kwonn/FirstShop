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
                <Navbar.Brand href="/">Kreamy</Navbar.Brand>
                <Navbar.Toggle aria-controls="basic-navbar-nav" />
                <Navbar.Collapse id="basic-navbar-nav">
                    <Nav className="me-auto">
                        <NavDropdown title="더보기" id="basic-nav-dropdown">
                            <NavDropdown.Item href="/product/listProduct">어떤걸</NavDropdown.Item>
                            <NavDropdown.Item href="/product/listProduct">고르셔도</NavDropdown.Item>
                            <NavDropdown.Item href="/product/listProduct">전부</NavDropdown.Item>
                            <NavDropdown.Divider />
                            <NavDropdown.Item href="/product/listProduct">쇼핑 리스트입니다.</NavDropdown.Item>
                            <NavDropdown.Item href="/product/listProduct">드롭다운 연습 하려고 만들었습니다.</NavDropdown.Item>
                        </NavDropdown>
                        <Nav.Link href="#raffle">Raffle.. 만들고 만다..</Nav.Link>
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