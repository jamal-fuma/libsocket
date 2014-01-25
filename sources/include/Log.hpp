#ifndef FUMA_LIBRARIES_CLIENT_LOG_H
#define FUMA_LIBRARIES_CLIENT_LOG_H

#include <iostream>
#include <sstream>
#include <unistd.h>
struct Log
{
        Log(const char *name)
            : m_name(name)
        {
        }

        template<typename T>
        Log & operator<<(T data)
        {
            m_msg << data;
            return *this;
        }

        ~Log()
        {
          std::cerr << "[" << ::getpid() << "] ";
          std::cerr << "[" << m_name << "] says: " << m_msg.str() << "\n";
        }

private:
        std::string m_name;
        std::stringstream m_msg;
};

#endif /* ndef FUMA_LIBRARIES_CLIENT_LOG_H */
