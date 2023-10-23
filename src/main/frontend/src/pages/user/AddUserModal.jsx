import { useState } from 'react';
import Button from 'react-bootstrap/Button';
import Modal from 'react-bootstrap/Modal';
import Nav from "react-bootstrap/Nav";
import {Col, Form, Row} from "react-bootstrap";
function AddUserModal() {
    const [show, setShow] = useState(false);
    const handleClose = () => setShow(false);
    const handleShow = () => setShow(true);

    const [user, setUser] = useState({});


    const handleChange = (e) => {
        const { name, value } = e.target;
        setUser((prevUser) => ({
            ...prevUser,
            [name]: value,
        }));
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        // 여기서 formData를 사용하여 로그인 로직을 처리하거나 서버에 요청을 보낼 수 있습니다.
        // 예: await fetch('/api/await addUser(user);
        try {
            // 여기서 formData를 사용하여 로그인 로직을 처리하거나 서버에 요청을 보낼 수 있습니다.
            console.log('Submitted Data:', user);

            // 예: await fetch('/api/login', { method: 'POST', body: JSON.stringify(formData) });
            await fetch('/user/addUser', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(user),
            });
        } catch (error){
            console.error("Error converting user object to JSON string:", error);
            return;
        }

        console.log('Submitted Data:', user);

        handleClose();
    };

    return (
        <>
            <Nav.Link onClick={handleShow}>
                회원가입
            </Nav.Link>

            <Modal show={show} onHide={handleClose}>
                <Form onSubmit={handleSubmit}>
                <Modal.Header closeButton>
                    <Modal.Title>회원가입</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <Row className="mb-3">
                    <Form.Group as={Col} className="mb-3" controlId="userId">
                        <Form.Label>아이디</Form.Label>
                        <Form.Control type="text" placeholder="아이디 입력" name="userId" onChange={handleChange} />
                        <Form.Text className="text-muted" id="userId">
                            {/* 여기서 validation check 문구 return 가능할듯. */}
                        </Form.Text>
                    </Form.Group>

                    <Form.Group as={Col} className="mb-3" controlId="password">
                        <Form.Label>비밀번호</Form.Label>
                        <Form.Control type="password" placeholder="비밀번호 입력" name="password" onChange={handleChange} />
                    </Form.Group>
                    </Row>

                    <Form.Group className="mb-3" controlId="userName">
                        <Form.Label>이름</Form.Label>
                        <Form.Control type="text" placeholder="성이름" name="userName" onChange={handleChange} />
                    </Form.Group>

                    <p style={{color: "red", fontWeight: "bold"}}>아이디, 비밀번호, 이름 입력 필수</p>
                    <hr/>

                    <Form.Group className="mb-3" controlId="phone">
                        <Form.Label>핸드폰 번호</Form.Label>
                        <Form.Control type="text" placeholder="'-' 제외 숫자 입력" name="phone" maxLength="11" onChange={handleChange}/>
                    </Form.Group>

                    <Form.Group className="mb-3" controlId="addr">
                            <Form.Label>거주지 주소</Form.Label>
                            <Form.Control type="text" placeholder="주소 입력" name="addr" onChange={handleChange}/>
                    </Form.Group>

                    <Form.Group className="mb-3" controlId="email">
                        <Form.Label>이메일 주소</Form.Label>
                        <Form.Control type="text" placeholder="id@example.com" name="email" onChange={handleChange}/>
                    </Form.Group>
                    {/*<Form.Group className="mb-3" controlId="formBasicCheckbox">*/}
                    {/*    <Form.Check type="checkbox" label="Check me out" />*/}
                    {/*</Form.Group>*/}
                </Modal.Body>
                <Modal.Footer>
                    <Button variant="secondary" onClick={handleClose}>
                        취소
                    </Button>
                    <Button type="submit" variant="primary">
                        가입
                    </Button>
                </Modal.Footer>
                </Form>
            </Modal>
        </>
    );
}

export default AddUserModal;