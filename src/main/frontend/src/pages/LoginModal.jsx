import { useState } from 'react';
import Button from 'react-bootstrap/Button';
import Modal from 'react-bootstrap/Modal';
import Nav from "react-bootstrap/Nav";
import {Form} from "react-bootstrap";
import Container from "react-bootstrap/Container";

// eslint-disable-next-line react/prop-types
function LoginModal({onLogin}) { // prop onLogin 추가 : 로그인 submit 시 동작
    const [show, setShow] = useState(false);
    const [formData, setFormData] = useState({
        userId: '',
        password: ''
    });

    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData({
            ...formData,
            [name]: value
        });
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        // 여기서 formData를 사용하여 로그인 로직을 처리하거나 서버에 요청을 보낼 수 있습니다.
        console.log('Submitted Data:', formData);
        // 예: await fetch('/api/login', { method: 'POST', body: JSON.stringify(formData) });
        if (onLogin) { // onLogin 함수가 제공되었을 때만 호출
            onLogin(formData.userId, formData.password);
        }
        handleClose();
    };

    const handleClose = () => setShow(false);
    const handleShow = () => setShow(true);

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
                        <Container>
                            <p>아이디 : <input className="input" type="text" id="userId" name="userId" placeholder="아이디를 입력해 주세요." onChange={handleChange}/></p>
                            <p>비밀번호 : <input className="input" type="text" id="password" name="password" placeholder="비밀번호를 입력해 주세요." onChange={handleChange}/></p>
                        </Container>
                    </Modal.Body>
                    <Modal.Footer>
                        <Button variant="secondary" onClick={handleClose}>
                            취소
                        </Button>
                        <Button type="submit" variant="primary">
                            로그인
                        </Button>
                    </Modal.Footer>
                </Form>
            </Modal>
        </>
    );
}

export default LoginModal;