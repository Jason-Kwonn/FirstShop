import {useContext, useState} from 'react';
import Button from 'react-bootstrap/Button';
import Modal from 'react-bootstrap/Modal';
import Nav from "react-bootstrap/Nav";
import {Form} from "react-bootstrap";
import {UserContext} from "../../contexts/user/UserContext.jsx";

// eslint-disable-next-line react/prop-types
function LoginModal({onLoginSuccess}) { // prop onLogin 추가 : 로그인 submit 시 동작

    const [show, setShow] = useState(false);
    const {setUser} = useContext(UserContext);
    const [localUser, setLocalUser] = useState({});

    const handleChange = (e) => {
        // const { name, value } = e.target;
        setLocalUser(prev =>({
            ...prev,
            [e.target.name]: e.target.value
        }));
        console.log(e.target.name, e.target.value);
    };

    // 사용자 정보 호출 함수
    const handleSubmit = async (e) => {
        e.preventDefault();
        console.log('Submitted Data:', localUser);

        try {
            const response = await fetch('/user/login', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(localUser),
            });
            console.log(JSON.stringify(localUser));

            const userData = await response.json();

            if (response.ok) {
                console.log("Login OK!!!", userData);
                setUser(userData);
                localStorage.setItem("user", JSON.stringify(userData));
                console.log(localStorage.getItem("user"));
                onLoginSuccess();
                handleClose();
            } else {
                console.log("What's wrong??", userData);
            }

        } catch (error) {
            console.error(error);
        }
    };

    const handleClose = () => setShow(false);
    const handleShow = () => setShow(true);

    // const naverLogin = async () => {
    //     const response = await fetch('https://nid.naver.com/oauth2.0/authorize')
    //     if (response.ok) {
    //         console.log(response.status);
    //     }
    // };


    return (
        <>
            <Nav.Link style={{paddingRight: '10px'}} onClick={handleShow}>
                    로그인
            </Nav.Link>

            <Modal show={show} onHide={handleClose}>

                <Form onSubmit={handleSubmit}>
                    <Modal.Header closeButton>
                        <Modal.Title>로그인</Modal.Title>
                    </Modal.Header>
                    <Modal.Body>
                            <Form.Group className="mb-3" controlId="userId">
                                <Form.Label>아이디</Form.Label>
                                <Form.Control type="text" placeholder="아이디를 입력해 주세요." name="userId" onChange={handleChange} />
                                <Form.Text className="text-muted">
                                    {/* 여기서 validation check 문구 return 가능할듯. */}
                                </Form.Text>
                            </Form.Group>

                            <Form.Group className="mb-3" controlId="password">
                                <Form.Label>비밀번호</Form.Label>
                                <Form.Control type="password" placeholder="비밀번호를 입력해 주세요." name="password" onChange={handleChange} />
                                <Form.Text className="text-muted">
                                    {/* 여기서 validation check 문구 return 가능할듯. */}
                                </Form.Text>
                            </Form.Group>
                    </Modal.Body>
                    <Modal.Footer>
                        <Button variant="secondary" onClick={handleClose}>
                            취소
                        </Button>
                        <Button type="submit" variant="primary">
                            로그인
                        </Button>
                    </Modal.Footer>
                    {/*<Modal.Footer style={{ padding: '20px 50px' }}>*/}
                    {/*    <Image src="/naver/btnG.png" alt="네이버로그인" onClick={naverLogin} style={{ width: '100px', height: '30px' }}/>*/}
                    {/*</Modal.Footer>*/}
                </Form>
            </Modal>
        </>
    );
}

export default LoginModal;