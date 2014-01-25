#ifndef FUMA_LIBRARIES_SOCKET_SOCKET_HPP
#define FUMA_LIBRARIES_SOCKET_SOCKET_HPP

class Address;

class Socket
{
public:
    Socket();
    virtual ~Socket();

    Socket(int sock);

    int set_reusable_address();
    void close();
    int bind(const Address & addr);

    int get_sockfd() const;

    Socket(const Socket & rhs);
    Socket & operator=(const Socket & rhs);
    void copy_assign(const Socket & rhs);
    void move_assign(Socket & rhs);
    void swap(Socket & rhs);

private:
    int m_sockfd;
};

#endif /* ndef FUMA_LIBRARIES_SOCKET_SOCKET_HPP */
