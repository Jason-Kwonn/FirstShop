import Container from 'react-bootstrap/Container';
import Nav from 'react-bootstrap/Nav';
import Navbar from 'react-bootstrap/Navbar';
import NavDropdown from 'react-bootstrap/NavDropdown';
import {Button, Form} from "react-bootstrap";
import {useEffect, useState} from "react";
import AddUserModal from "../pages/AddUserModal.jsx";
import LoginModal from "../pages/LoginModal.jsx";

function NavBar() {
    const [isLoggedIn, setIsLoggedIn] = useState(false);
    const [user, setUser] = useState(null);
    const [showAddUserModal, setShowAddUserModal] = useState(false);

    const [showLoginModal, setShowLoginModal] = useState(false);

    const handleLoginClose = () => setShowLoginModal(false);
    // const handleLoginShow = () => setShowLoginModal(true);
    const handleAddUserClose = () => setShowAddUserModal(false);
    // const handleAddUserShow = () => setShowAddUserModal(true);

    // 사용자 정보 호출 함수
    const loginUser = async (userId, password) => {
        try {
            const response = await fetch('/user/login', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ userId, password }),
            });

            if (!response.ok) {
                console.log('Login failed!');
            }

            const userData = await response.json();
            setUser(userData);
            setIsLoggedIn(true);
        } catch (error) {
            console.error(error);
        }
    };

    const logoutUser = () => setIsLoggedIn(false);

    useEffect(() => {
        // user 상태가 변경될 때 로그인 상태 새로 갱신
        setIsLoggedIn(user !== null);
    }, [user]);

    return (
        <Navbar expand="lg" className="bg-body-tertiary">
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
                    <Form className="d-flex" style={{marginRight: '20px'}}>
                        <Form.Control
                            type="search"
                            placeholder="Search"
                            className="me-2"
                            aria-label="Search"
                        />
                        <Button variant="outline-success">Search</Button>
                    </Form>
                    <Nav>
                        {isLoggedIn ? (
                            <>
                                <Nav.Link onClick="/user/getUser">내정보</Nav.Link>
                                <Nav.Link onClick={logoutUser}>로그아웃</Nav.Link>
                            </>
                        ) : (
                            <>
                                <LoginModal onLogin={loginUser} show={showLoginModal} handleClose={handleLoginClose} />
                                <AddUserModal show={showAddUserModal} handleClose={handleAddUserClose} />
                            </>
                        )}
                    </Nav>
                </Navbar.Collapse>
            </Container>
        </Navbar>
    );
}

export default NavBar;