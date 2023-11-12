import {useContext, useState} from 'react';
import Button from 'react-bootstrap/Button';
import Form from 'react-bootstrap/Form';
import {Link} from "react-router-dom";
import {UserContext} from "../../contexts/user/UserContext.jsx";

function GetUser() {
    const [validated, setValidated] = useState(false);
    const [isGetUser, setIsGetUser] = useState(true);
    const {user, setUser, allUser} = useContext(UserContext);
    const [isNameDuplicated, setIsNameDuplicated] = useState(false);
    const [isPhoneDuplicated, setIsPhoneDuplicated] = useState(false);
    const [isPhoneValid, setIsPhoneValid] = useState(true);
    const [isEmailDuplicated, setIsEmailDuplicated] = useState(false);


    const handleUpdateButton = () => {
        setIsGetUser(false);
    };

    const handleSubmit = async (event) => {
        event.preventDefault();

        try {
            const response = await fetch('/user/updateUser', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(user),
            });
            console.log('Submitted Data:', user);

            if (response.ok) {
                localStorage.setItem("user", user);
                alert("수정 완료!");
                setIsGetUser(true);
            }
        }

        catch (error) {
            console.error(error);
        }
    };

    const handleChange = (e) => {
        // const { name, value } = e.target;
        setUser(prev =>({
            ...prev,
            [e.target.name]: e.target.value,
        }));

        if (e.target.name === 'userName' && allUser.some(u => u.userName === e.target.value)) {
            setIsNameDuplicated(true);
        } else if (name === 'userName') {
            setIsNameDuplicated(false);
        }

        if (e.target.name === 'phone') {
            // 중복된 전화번호가 있는지 확인
            if (allUser.some(u => u.phone === e.target.value )) {
                setIsPhoneDuplicated(true);
            } else {
                setIsPhoneDuplicated(false);
            }

            // 숫자만 포함된 문자열인지 확인
            const isNumericOrNegative = /^-?[0-9]+(\.[0-9]+)?$/.test(e.target.value);
            setIsPhoneValid(isNumericOrNegative);
        }

        if (e.target.name === 'email') {
            if (allUser.some(u => u.email === e.target.value)) {
                setIsEmailDuplicated(true);
            }
        }

        if (isEmailDuplicated === false
            && isPhoneDuplicated === false
            && isNameDuplicated === false
            && isPhoneValid === true) {
            setValidated(true);
        }
    };

    return (
        <>
            <Form noValidate validated={validated} onSubmit={handleSubmit}
                  className="container col-md-5 align-self-center mt-5 col-form-label-lg col-form-text-lg">
                <Form.Text className="text-center">
                    <h1>내 정보</h1>
                </Form.Text>
                <Form.Group className="mb-3" controlId="userId">
                    <Form.Label>아이디</Form.Label>
                    <Form.Control
                        required
                        name="userId"
                        type="text"
                        placeholder="아이디"
                        defaultValue={user.userId}
                        disabled
                        onChange={handleChange}
                    />
                    <Form.Control.Feedback></Form.Control.Feedback>
                </Form.Group>
                <Form.Group className="mb-3" controlId="password">
                    <Form.Label>비밀번호</Form.Label>
                    <Form.Control
                        required
                        name="password"
                        type="password"
                        placeholder="비밀번호"
                        defaultValue=""
                        disabled={isGetUser}
                        onChange={handleChange}
                    />
                    <Form.Control.Feedback>입력 완료</Form.Control.Feedback>
                    <Form.Control.Feedback type="invalid">비밀번호를 입력해 주세요.</Form.Control.Feedback>
                </Form.Group>
                <Form.Group className="mb-3" controlId="userName">
                    <Form.Label>이름</Form.Label>
                    <Form.Control
                        required
                        name="userName"
                        type="text"
                        placeholder="성과 이름을 입력해 주세요."
                        defaultValue={user.userName}
                        disabled={isGetUser}
                        onChange={handleChange}
                        isInvalid={isNameDuplicated}
                    />
                    <Form.Control.Feedback>
                        입력 완료
                    </Form.Control.Feedback>
                    <Form.Control.Feedback type="invalid">
                        이미 가입된 회원입니다.
                    </Form.Control.Feedback>
                </Form.Group>
                <Form.Group className="mb-3" controlId="phone">
                    <Form.Label>전화번호</Form.Label>
                    <Form.Control
                        name="phone"
                        type="text"
                        placeholder="'-' 를 제외한 11자리 수만 입력해 주세요."
                        defaultValue={user.phone}
                        maxLength="11"
                        disabled={isGetUser}
                        onChange={handleChange}
                        isInvalid={isPhoneDuplicated || !isPhoneValid}
                    />
                    <Form.Control.Feedback>
                        입력 완료
                    </Form.Control.Feedback>
                    <Form.Control.Feedback type="invalid">
                        {isPhoneDuplicated ? '이미 가입된 회원입니다.' : '전화번호는 숫자만 입력해야 합니다.'}
                    </Form.Control.Feedback>
                </Form.Group>
                <Form.Group  className="mb-3" controlId="addr">
                    <Form.Label>주소</Form.Label>
                    <Form.Control
                        name="addr"
                        type="text"
                        placeholder="주소 입력"
                        defaultValue={user.addr}
                        disabled={isGetUser}
                        onChange={handleChange}
                    />
                    <Form.Control.Feedback>
                        입력 완료
                    </Form.Control.Feedback>
                    <Form.Control.Feedback type="invalid">

                    </Form.Control.Feedback>
                </Form.Group>

                <Form.Group  className="mb-3" controlId="email">
                    <Form.Label>이메일</Form.Label>
                    <Form.Control
                        name="email"
                        type="text"
                        placeholder="host@kreamy.com"
                        defaultValue={user.email}
                        disabled={isGetUser}
                        onChange={handleChange}
                        isInvalid={isEmailDuplicated}
                    />
                    <Form.Control.Feedback>
                        입력 완료
                    </Form.Control.Feedback>
                    <Form.Control.Feedback type="invalid">
                        이메일이 중복되었습니다.
                    </Form.Control.Feedback>
                </Form.Group>

                {/* getUser 상태이면 수정 버튼 / 아닐 시 취소, 수정 완료 버튼*/}
                {isGetUser ?
                <Form.Group className="text-end" onClick={handleUpdateButton} >
                    <Button id="update">수정</Button>
                </Form.Group>
                :
                <Form.Group className="text-end" >
                    <Button id="cancel" variant="secondary" as={Link} to="/">취소</Button>
                    <Button id="submit" className="m-2" type="submit" variant="primary">수정 완료</Button>
                </Form.Group>
                }
            </Form>
        </>
    );
}

export default GetUser;