import Container from 'react-bootstrap/Container';
import Nav from 'react-bootstrap/Nav';
import Navbar from 'react-bootstrap/Navbar';
import NavDropdown from 'react-bootstrap/NavDropdown';
import {useContext, useEffect, useState} from "react";
import LoginModal from "../../pages/user/LoginModal.jsx";
import AddUserModal from "../../pages/user/AddUserModal.jsx";
import {Link} from "react-router-dom";
import {UserContext} from "../../contexts/user/UserContext.jsx";
import SearchBar from "./SearchBar.jsx";
import "./NavBar.css";

function NavBar() {

    const { user, isLoggedIn, setIsLoggedIn } = useContext(UserContext);
    const [showLoginModal, setShowLoginModal] = useState(false);
    const [showAddUserModal, setShowAddUserModal] = useState(false);
    const [isAdminUser, setIsAdminUser] = useState(false);

    const handleLoginClose = () => setShowLoginModal(false);
    const handleAddUserClose = () => setShowAddUserModal(false);

    useEffect(() => {
        const checkIsAdminUser = () => {
            if (user.role === "admin") {
                console.log(user.role);
                setIsAdminUser(true);
            } else {
                console.log(user.role);
            }
        };

        checkIsAdminUser();
    }, [user]);

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
                <Navbar.Brand as={Link} to="/">Rafflex</Navbar.Brand>
                <Navbar.Toggle aria-controls="basic-navbar-nav" />
                <Navbar.Collapse id="basic-navbar-nav">
                    <Nav className="me-auto">
                        <NavDropdown title="쇼핑하기" id="basic-nav-dropdown">
                            <NavDropdown.Item as={Link} to="/product/getProductList">상품 리스트</NavDropdown.Item>
                            {isAdminUser && (
                                <>
                                    <NavDropdown.Item as={Link} to="/product/addProduct">상품 추가</NavDropdown.Item>
                                </>
                            )}
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
                                <SearchBar/>
                            </>
                        ) : (
                            <>
                                <LoginModal show={showLoginModal} handleClose={handleLoginClose} onLoginSuccess={loginSuccess}/>
                                <AddUserModal show={showAddUserModal} handleClose={handleAddUserClose} />
                                <SearchBar/>
                            </>
                        )}
                    </Nav>
                </Navbar.Collapse>
            </Container>
        </Navbar>
    );
}

export default NavBar;