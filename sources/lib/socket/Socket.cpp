#include "Socket.hpp"
#include "Address.hpp"
#include "Detail.hpp"
#include "Log.hpp"

Socket::Socket()
: m_sockfd(-1)
{
    Log("Socket::default_construct()") << "got new socket with value " << m_sockfd;
}

Socket::Socket(int sockfd)
: m_sockfd(sockfd)
{
    Log("Socket::construct()") << "got new socket with value " << m_sockfd;
}

int Socket::get_sockfd() const
{
    return m_sockfd;
}

Socket::~Socket()
{
    close();
}

void
Socket::close()
{
    if(m_sockfd != -1)
        detail::close_socket(m_sockfd);
    m_sockfd = -1;
}

int
Socket::set_reusable_address()
{
    int yes = 1;
    return ::setsockopt(
            m_sockfd,
            SOL_SOCKET, SO_REUSEADDR,
            &yes, sizeof(yes)
    );
}

int
Socket::bind(const Address & addr)
{
    return detail::bind(m_sockfd, addr.get_addr(), addr.get_size());
}

Socket::Socket(const Socket & rhs)
{
    copy_assign(rhs);
}

Socket & Socket::operator=(const Socket & rhs)
{
    copy_assign(rhs);
    return *this;
}

void
Socket::copy_assign(const Socket & rhs)
{
    if(this != &rhs)
    {
        Log("Socket::copy_assign()") << "assign socket with value "
                                << m_sockfd
                                << " to socket with value "
                                << rhs.m_sockfd ;

        m_sockfd   = rhs.m_sockfd;
    }
}


void
Socket::move_assign(Socket & rhs)
{
    if(this != &rhs)
    {
        Log("Socket::move_assign()")
                                << "forget socket with value " << m_sockfd
                                << " acquire socket with value " << rhs.m_sockfd ;

        m_sockfd   = rhs.m_sockfd;

        rhs.m_sockfd = -1;
    }
}


void Socket::swap(Socket & rhs)
{
    if(&rhs != this)
    {
        Log("Socket::swap()") << "swap socket with value "
                                << m_sockfd
                                << " for socket with value "
                                << rhs.m_sockfd ;

        std::swap(m_sockfd,rhs.m_sockfd);
    }
}
